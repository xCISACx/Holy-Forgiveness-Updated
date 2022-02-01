using System;
using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;

public class SmallPillarBehaviour : MonoBehaviour
{
	public enum PushType
	{
		Front,
		Back,
		Left,
		Right
	}

	/*[SerializeField] private GameObject pillarPushPointFront;
	[SerializeField] private GameObject pillarPushPointBack;
	[SerializeField] private GameObject pillarPushPointLeft;
	[SerializeField] private GameObject pillarPushPointRight;

	[SerializeField] private BoxCollider pillarPushPointFrontCollider;
	[SerializeField] private BoxCollider pillarPushPointBackCollider;
	[SerializeField] private BoxCollider pillarPushPointLeftCollider;
	[SerializeField] private BoxCollider pillarPushPointRightCollider;*/
	
	public PushType pushType;
	public bool pushFront;
	public bool pushBack;
	public bool pushLeft;
	public bool pushRight;
	public bool pushed;
	public Animator smallPillarAnim;
	public YuutaPlayerBehaviour Yuuta;
	public TextMeshPro number;
	public string numberText;

	// Use this for initialization
	void Start ()
	{
		smallPillarAnim = transform.parent.parent.GetComponent<Animator>();
		Yuuta = FindObjectOfType<YuutaPlayerBehaviour>();
		if (number != null)
		{
			number = transform.parent.GetComponentInChildren<TextMeshPro>();
			number.text = numberText;
		}
	}
	
	// Update is called once per frame
	void Update () 
	{
		if (!Yuuta)
		{
			Yuuta = FindObjectOfType<YuutaPlayerBehaviour>();
		}
		
		if (pushFront || pushBack || pushLeft || pushRight)
		{
			pushed = true;
		}
		
		smallPillarAnim.SetBool("fall front", pushBack);
		smallPillarAnim.SetBool("fall back", pushFront);
		smallPillarAnim.SetBool("fall right", pushLeft);
		smallPillarAnim.SetBool("fall left", pushRight);
	}

	private void OnTriggerStay(Collider other)
	{
		if (other.gameObject.CompareTag("Yuuta"))
		{
			switch (pushType)
			{
				case PushType.Front:
					if (Input.GetButtonDown("R1") && !pushed)
					{
						Yuuta.GetComponent<Animator>().SetBool("pushed", true);
						StartCoroutine(WaitBeforeChangingAnimation());
						pushFront = true;
						//Debug.Log("Pushed front point, falling back");
					}
					break;

				case PushType.Back:
				{
					if (Input.GetButtonDown("R1") && !pushed)
					{
						Yuuta.GetComponent<Animator>().SetBool("pushed", true);
						StartCoroutine(WaitBeforeChangingAnimation());
						pushBack = true;
						//Debug.Log("Pushed back point, falling front");
					}
					break;
				}

				case PushType.Left:
				{
					if (Input.GetButtonDown("R1") && !pushed) 
					{
						Yuuta.GetComponent<Animator>().SetBool("pushed", true);
						StartCoroutine(WaitBeforeChangingAnimation());
						pushLeft = true;
						//Debug.Log("Pushed left point, falling right");
					}
					break;
				}

				case PushType.Right:
				{
					if (Input.GetButtonDown("R1") && !pushed)
					{
						Yuuta.GetComponent<Animator>().SetBool("pushed", true);
						StartCoroutine(WaitBeforeChangingAnimation());
						pushRight = true;
						//Debug.Log("Pushed right point, falling left");
					}
					break;
				}
			}
		}
	
	}
	
	private void PlayAnimation()
	{
		if (pushFront || pushBack || pushLeft || pushRight)
		{
			smallPillarAnim.SetBool("fall back", true);
		}
	
		if (pushBack)
		{
			smallPillarAnim.SetBool("fall front", true);
		}
	
		if (pushLeft)
		{
			smallPillarAnim.SetBool("fall right", true);
		}
	
		if (pushRight)
		{
			smallPillarAnim.SetBool("fall left", true);
		}
	}
	
	IEnumerator WaitBeforeChangingAnimation()
	{
		yield return new WaitForSeconds(0.8f);
		Yuuta.GetComponent<Animator>().SetBool("pushed", false);
	}
}
