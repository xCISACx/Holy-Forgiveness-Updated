using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RockBehaviour : MonoBehaviour
{
    public enum RockType
    {
        Sinkable,
        Stable
    }

    public RockType rockType;
    public Vector3 defaultPosition;
    public float rockRespawnTime;
    public float timeBeforeSinking;
        
    // Start is called before the first frame update
    void Start()
    {
        defaultPosition = this.gameObject.transform.position;
    }

    private void OnCollisionStay(Collision other)
    {
        if (other.gameObject.CompareTag("Kuro"))
        {
            //Debug.Log("Colliding with Kuro");
            
            if (rockType == RockType.Sinkable)
            {
                StartCoroutine(Sink());
            }
        }
    }

    IEnumerator Sink()
    {
        yield return new WaitForSeconds(timeBeforeSinking);
        this.gameObject.GetComponent<Rigidbody>().isKinematic = false;
        yield return new WaitForSeconds(rockRespawnTime);
        gameObject.GetComponent<Rigidbody>().isKinematic = true;
        this.gameObject.transform.position = defaultPosition;
    }
}
