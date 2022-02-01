using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class KeyBehaviour : MonoBehaviour
{

    public GameObject Kuro;
    public bool pickedUp;
    // Start is called before the first frame update
    void Awake()
    {
        Kuro = FindObjectOfType<KuroPlayerBehaviour>().gameObject;
    }

    // Update is called once per frame
    void Update()
    {
        if (!Kuro)
        {
            Kuro = FindObjectOfType<KuroPlayerBehaviour>().gameObject;
        }
        
        if (Kuro && GameManager.instance.KuroHasKey)
        {
            transform.parent = GameManager.instance.KuroHand;
            transform.position = GameManager.instance.KuroHand.position;
            transform.rotation = GameManager.instance.KuroHand.rotation;
            Kuro.GetComponent<KuroPlayerBehaviour>().hasKey = true;
            GameManager.instance.KuroHasKey = true;
            GetComponent<Collider>().isTrigger = true;
        }
        else
        {
            GetComponent<Collider>().isTrigger = false;
        }
    }
    
    private void OnCollisionStay(Collision other)
    {
        if (other.gameObject.CompareTag("Kuro"))
        {
            //Debug.Log("Touching Kuro");
            if (Input.GetButtonDown("R1"))
            {
                GameManager.instance.KuroHasKey = true;
            }
        }
    }
}
