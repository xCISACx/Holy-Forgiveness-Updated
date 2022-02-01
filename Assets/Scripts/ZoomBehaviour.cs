using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class ZoomBehaviour : MonoBehaviour {
	
	public Camera mainCamera;
	public float defaultZoomRate;
	public float zoomRate;

	public float maxOrtographicSize = 12;
	public float minOrtographicSize = 2;

	public Slider slider;

	// Use this for initialization
	void Start ()
	{

		mainCamera = Camera.main;

	}
	
	// Update is called once per frame
	void Update () {
		
		if (mainCamera.orthographicSize > maxOrtographicSize)
		{
			zoomRate = 0;
			mainCamera.orthographicSize = maxOrtographicSize;
		}
		else if (mainCamera.orthographicSize >= maxOrtographicSize)
		{
			zoomRate = defaultZoomRate;
		}
		
		if (mainCamera.orthographicSize < minOrtographicSize)
		{
			zoomRate = 0;
			mainCamera.orthographicSize = minOrtographicSize;
		}
		else if (mainCamera.orthographicSize >= minOrtographicSize)
		{
			zoomRate = defaultZoomRate;
		}

		if (Input.GetButton("R2") || Input.GetAxis("Mouse ScrollWheel") > 0.05)
		{
			// Debug.Log("R2 pressed");
			
			mainCamera.orthographicSize -= zoomRate;
		}

		if (Input.GetButton("L2") || Input.GetAxis("Mouse ScrollWheel") < -0.05)
		{
			// Debug.Log("L2 pressed");

			mainCamera.orthographicSize += zoomRate;
		}

		slider.value = mainCamera.orthographicSize;
	}
}
