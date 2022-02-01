using System.Collections;
using System.Collections.Generic;
using FMOD;
using UnityEngine;
using Debug = UnityEngine.Debug;

public class CubeBehaviour : MonoBehaviour
{

	public Rigidbody rb;
    public GameObject Yuuta;
    public Transform boxTransform;
    public Vector3 defaultPosition;
    public float speed;
    public bool moving;
    public LayerMask layer;
    public Vector3 desiredPosition;
    public bool pushed;
    
    public FMOD.Studio.EventInstance PlayPushingSound;
    public FMOD.Studio.EventInstance PlayGruntingSound;

    public bool canPlayGrunt;
    
    // Start is called before the first frame update
    void Start()
    {
        rb = GetComponent<Rigidbody>();
        Yuuta = GameObject.FindWithTag("Yuuta");
        PlayPushingSound = FMODUnity.RuntimeManager.CreateInstance("event:/SFX/Characters/Yuuta/Yuuta Box Pushing");
        PlayGruntingSound = FMODUnity.RuntimeManager.CreateInstance("event:/SFX/Characters/Yuuta/Yuuta Grunt");
    }

    // Update is called once per frame
    void Update()
    {
        //float move = speed * Time.deltaTime;
        //transform.position = Vector3.MoveTowards(transform.position, Player.transform.up, move);
    }

    private void OnCollisionStay(Collision other)
    {
        if (other.gameObject.CompareTag("Yuuta"))
        {
            if (Input.GetButtonDown("R1") && !moving)
            {
                Yuuta.GetComponent<Animator>().SetBool("pushed", true);
                var normalize = new Vector3(Mathf.Round(other.contacts[0].normal.x), 0, Mathf.Round(other.contacts[0].normal.z));
                StartCoroutine(Push(normalize));
                
                //Vector3 playerForward = Vector3.Scale(Player.transform.position.x, Player.transform.forward.x);
                //float move = speed;
                //transform.position = Vector3.MoveTowards(transform.position, Player.transform.up, move);
                //transform.Translate(Player.transform.forward * move, Space.Self);
            }
        }
    }

    private bool CheckPath(Vector3 desiredPosition)
    {
        Collider[] detectedColliders;
        detectedColliders = Physics.OverlapBox(desiredPosition, (transform.GetComponent<BoxCollider>().size * 0.99f)/2, Quaternion.identity, layer);
        
        int i = 0;
        //Check when there is a new collider coming into contact with the box
        while (i < detectedColliders.Length)
        {
            //Output all of the collider names
            Debug.Log("Hit : " + detectedColliders[i].name + "(" + i + "), tag: " + detectedColliders[i].tag + "(" + i + ")");
            //Increase the number of Colliders in the array
            i++;
        }
        
        foreach (Collider col in detectedColliders)
        {
            /*if (col.gameObject.GetInstanceID() != gameObject.GetInstanceID())
                continue;*/
            if (col.gameObject.CompareTag("Box") || col.gameObject.CompareTag("Wall") || col.gameObject.CompareTag("Kari")
                || col.gameObject.CompareTag("Yuuta") || col.gameObject.CompareTag("Kuro") || col.gameObject.CompareTag("Ground")
                || col.gameObject.CompareTag("Pillar") || col.gameObject.CompareTag("Fallen Pillar"))
            {
                Debug.Log("Can't.");
                PlayGruntingSound.start();
                return false;
            }
        }
        return true;
    }

    IEnumerator Push(Vector3 dir)
    {
        StartCoroutine(WaitBeforeChangingAnimation());
        //Debug.Log(speed);
        moving = true;
        desiredPosition = (transform.position + dir * 3);
        //Debug.Log(transform.position + "+" + (Yuuta.transform.forward * 3f));
        if (!CheckPath(desiredPosition))
        {
            moving = false;
            canPlayGrunt = true;
            yield break;
        }
        else
        {
            PlayPushingSound.start();
        }
        while (transform.position != desiredPosition)
        {
            transform.position = Vector3.MoveTowards(transform.position, desiredPosition, speed * Time.deltaTime);
            //Debug.Log("position: " + transform.position + "desired position: " + desiredPosition);
            yield return new WaitForFixedUpdate();
        }
        moving = false;
        PlayPushingSound.stop(FMOD.Studio.STOP_MODE.ALLOWFADEOUT);
        yield return new WaitForSeconds(1);
    }
    
    void OnDrawGizmos()
    {
        Gizmos.color = Color.red;
        //Check that it is being run in Play Mode, so it doesn't try to draw this in Editor mode
        if (moving)
            //Draw a cube where the OverlapBox is (positioned where your GameObject is as well as a size)
            Gizmos.DrawWireCube(desiredPosition, new Vector3(2.5f,2.5f,2.5f));
        //Debug.Log(transform.localScale);
    }

    IEnumerator WaitBeforeChangingAnimation()
    {
        yield return new WaitForSeconds(0.8f);
        Yuuta.GetComponent<Animator>().SetBool("pushed", false);
    }

    IEnumerator PlayGruntSound()
    {
        FMODUnity.RuntimeManager.PlayOneShot ("event:/SFX/Characters/Yuuta/Yuuta Grunt", transform.position);
        canPlayGrunt = false;
        yield return new WaitForSeconds(1);
    }
}
