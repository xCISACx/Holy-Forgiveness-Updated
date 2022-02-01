using System;
using UnityEngine;
using System.Collections;
using System.Collections.Generic;
using UnityEngine.Experimental.XR;
// ReSharper disable Unity.PreferNonAllocApi

public class CameraFollow : MonoBehaviour
{

    public static CameraFollow instance;
    public GameObject lastTarget;
    public GameObject target;

    public Vector3 offset;
    public Vector3 offset2;
    public RaycastHit oldHit;
    public List<GameObject> HitWalls;
    public List<GameObject> HitWalls2;
    public RaycastHit[] m_Results = new RaycastHit[5];
    public LayerMask layerMask;

    // Use this for initialization
    void Start()
    {
    }

    private void Awake()
    {
        if (instance == null)
        {
            instance = this;
        }
    }

    void Update()
    {
        if (lastTarget == target)
        {
            target = lastTarget;
        }
    }
	
    // LateUpdate is called after Update each frame
    void LateUpdate () 
    {
        // Set the position of the camera's transform to be the same as the target's.
        transform.position = target.transform.position + offset;
    }
}