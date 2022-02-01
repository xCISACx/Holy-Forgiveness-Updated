using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;

public class GemBehaviour : MonoBehaviour
{
	public Animator gemAnim;
	public bool isActivated;
	public PuzzleSolution Puzzle;
	public char gemNumber;
	public string playerCombinationString;
	public string correctCombinationString;

	// Use this for initialization
	void Start ()
	{
		gemAnim = GetComponent<Animator>();
		Puzzle.Gems.Add(this);
	}
	
	// Update is called once per frame
	void Update () 
	{
		gemAnim.SetBool("activated", isActivated);
		// Debug.Log("gem state was changed to" + gemAnim.GetBool("activated"));
	}

	private void OnCollisionEnter(Collision other)
	{
		if (other.gameObject.CompareTag("Projectile"))
		{
			isActivated = !isActivated;
			Puzzle.CurrentSolution += gemNumber;

			if (Puzzle.CurrentSolution.Length > Puzzle.Solution.Length)
			{
				Puzzle.CurrentSolution = "";
			}
		}
	}
}
