using System.Collections;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;

public class CubeResetBehaviour : MonoBehaviour
{
    public Animator leverAnim;
    public bool isActivated;
    public CubeBehaviour[] Cubes;
    public GameObject[] Pillars;
    public List<SmallPillarBehaviour> Behaviours;
    
    // Start is called before the first frame update
    void Start()
    {
        leverAnim = GetComponentInChildren<Animator>();
        Cubes = FindObjectsOfType<CubeBehaviour>();

        foreach (var cube in Cubes)
        {
            cube.defaultPosition = cube.transform.position;
        }

        for (int i = 0; i < Pillars.Length; i++)
        {
            Behaviours.AddRange(Pillars[i].GetComponentsInChildren<SmallPillarBehaviour>().ToArray());
        }

        // foreach (var pillar in Pillars)
        // {
        //     // pillar.GetComponent<Animator>().SetBool("fall right", false);
        //     // pillar.GetComponent<Animator>().SetBool("fall left", false);
        //
        //     if (pillar.GetComponentInChildren<SmallPillarBehaviour>().enabled)
        //     {
        //         Behaviours.Add(pillar.GetComponentInChildren<SmallPillarBehaviour>());   
        //     }
        //
        //
        // }
    }

    // Update is called once per frame
    void Update()
    {
        leverAnim.SetBool("activated", isActivated);
    }

    private void OnCollisionStay(Collision other)
    {
        if (other.gameObject.CompareTag("Kuro") || other.gameObject.CompareTag("Yuuta") || 
            other.gameObject.CompareTag("Kari"))
        {
            Debug.Log("Touching player...");
            
            if (Input.GetButtonDown("R1") || Input.GetMouseButtonDown(0))
            {
                Debug.Log("Resetting cube puzzle.");
                isActivated = true;

                foreach (var cube in Cubes)
                {
                    cube.transform.position = cube.defaultPosition;
                }
                
                foreach (var t in Behaviours)
                {
                    t.pushed = false;
                }

                StartCoroutine(WaitBeforeResettingLever());
            }
        }
    }

    IEnumerator WaitBeforeResettingLever()
    {
        //AnimationClip clip = GetComponent<Animation>().GetClip("lever pull");
        yield return new WaitForSeconds(leverAnim.GetCurrentAnimatorStateInfo(0).length * 2);
        isActivated = false;
    }
}
