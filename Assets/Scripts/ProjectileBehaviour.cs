using System.Collections;
using System.Collections.Generic;
using System.Timers;
using UnityEngine;
using UnityEngine.Video;

public class ProjectileBehaviour : MonoBehaviour
{
    public float timeToDestroy = 0.01f;

    private void OnCollisionEnter(Collision other)
    {
        
        //Debug.Log(other.gameObject);
        Destroy(gameObject, timeToDestroy);
    }
}
