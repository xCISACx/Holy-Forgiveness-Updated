using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;
using UnityEngine.Assertions.Must;

public class ObstructionChecker : MonoBehaviour
{
    public LayerMask LayerMask;
    public List<ObstructionBehaviour> HitObstructions;
    public List<ObstructionBehaviour> HitObstructions2;
    public List<ObstructionBehaviour> NotHitObstructions2;
    public List<ObstructionBehaviour> AllObstructions;
    public Material DefaultMaterial;
    
    // Start is called before the first frame update
    void Start()
    {
        AllObstructions = new List<ObstructionBehaviour>(FindObjectsOfType<ObstructionBehaviour>());
    }

    // Update is called once per frame
    void LateUpdate()
    {
        CheckForObstructions();

        // RaycastHit hit;
        // if (Physics.Linecast(transform.position, CameraFollow.instance.target.transform.position, out hit))
        // {
        //     if (hit.transform.gameObject.GetComponent<ObstructionBehaviour>() && 
        //         !hit.transform.gameObject.GetComponent<ObstructionBehaviour>().IsObstructing)
        //     {
        //         AllObstructions.Remove(hit.transform.gameObject.GetComponent<ObstructionBehaviour>());
        //         var renderer = hit.transform.gameObject.GetComponent<Renderer>();
        //         Debug.Log(hit.transform.gameObject.name);
        //         hit.transform.gameObject.GetComponent<ObstructionBehaviour>().IsObstructing = true;
        //         renderer.material.shader = Shader.Find("Transparent/Diffuse");
        //         Color tempColor = renderer.material.color;
        //         tempColor.a = 0.5F;
        //         renderer.material.color = tempColor;  
        //         HitObstructions2.Add(hit.transform.gameObject.GetComponent<ObstructionBehaviour>());
        //     }
        // }
        // else
        // {
        //     if (GetComponent<ObstructionBehaviour>())
        //     {
        //         HitObstructions2.Remove(hit.transform.gameObject.GetComponent<ObstructionBehaviour>());   
        //     }
        // }
    }

    private void CheckForObstructions()
    {
        var dir = (CameraFollow.instance.target.transform.position - transform.position).normalized;
        var hits = Physics.RaycastAll(transform.position, dir, Vector3.Distance(transform.position, CameraFollow.instance.target.transform.position), LayerMask);
        Debug.DrawRay(transform.position, dir, Color.red);

        for (var index = 0; index < hits.Length; index++)
        {
            Debug.Log(index);
            var hit = hits[index];
            Renderer rend = hit.transform.GetComponent<Renderer>();

            if (rend)
            {
                if (!HitObstructions.Contains(rend.GetComponent<ObstructionBehaviour>()))
                {
                    if (rend.GetComponent<ObstructionBehaviour>())
                    {
                        HitObstructions.Add(rend.GetComponent<ObstructionBehaviour>());
                        rend.GetComponent<ObstructionBehaviour>().IsObstructing = true;
                        rend.material.shader = Shader.Find("Transparent/Diffuse");
                        Color tempColor = rend.material.color;
                        tempColor.a = 0.5F;
                        rend.material.color = tempColor;
                    }
                }

                if (hits[index + 1 % hits.Length].transform.gameObject != hits[index].transform.gameObject)
                {
                    if (GetComponent<ObstructionBehaviour>())
                    {
                        Debug.Log("new hit: " + hits[index + 1].collider.name + "/n previous hit: " +
                                  hits[index].collider.name);
                        hits[index].transform.gameObject.GetComponent<ObstructionBehaviour>().IsObstructing = false;
                        Color tempColor2 = hits[index].transform.gameObject.GetComponent<Renderer>().material.color;
                        tempColor2.a = 1f;
                        hits[index].transform.gameObject.GetComponent<Renderer>().material.color = tempColor2;
                        HitObstructions.Remove(hits[index].transform.gameObject.GetComponent<ObstructionBehaviour>());   
                    }
                }
            }
        }
    }

    private void OnDrawGizmos()
    {
        Gizmos.color = Color.red;
        Gizmos.DrawWireSphere(transform.position, 2);
        Gizmos.color = Color.blue;
        if (CameraFollow.instance) Gizmos.DrawLine(transform.position, CameraFollow.instance.target.transform.position);
    }
}
