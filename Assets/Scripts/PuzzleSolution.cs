using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using UnityEditor;
using UnityEngine;
using UnityEngine.Events;

public class PuzzleSolution : MonoBehaviour
{
    public string Solution;

    public string ReversedSolution;

    public string CurrentSolution;

    public UnityEvent[] SolutionAction;
    
    [HideInInspector]
    public List<GemBehaviour> Gems = new List<GemBehaviour>();

    public bool isReversible;

    [SerializeField]
    private bool solutionFound;
    [SerializeField]
    private bool reversedSolutionFound;

    public bool gemsReset;
    
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        if (isReversible)
        {
            ReversedSolution = ReverseString(Solution);

            if (solutionFound)
            {
                //Debug.Log("Normal Solution was found");
                    
                if (ReversedSolution == CurrentSolution)
                {
                    StartCoroutine(PlayReverseStinger());
                    Debug.Log("Input reversed solution");
                    reversedSolutionFound = true;
                    SolutionAction[1].Invoke();
                    CurrentSolution = "";
                }
            }
        }
        
        if (Solution == CurrentSolution)
        {
            StartCoroutine(PlayStinger());
            SolutionAction[0].Invoke();
            CurrentSolution = "";
            
            if (CurrentSolution.Length > Solution.Length)
            {
                CurrentSolution = "";
            }
        }

        solutionFound = true;

        for (int i = 0; i < CurrentSolution.Length; i++)
        {
            if (CurrentSolution[i] != Solution[i] && CurrentSolution[i] != Solution[Solution.Length-1-i])
            {
                solutionFound = false;
            }
        }

        if (solutionFound)
        {
            for (int i = 0; i < CurrentSolution.Length; i++)
            {
                if (CurrentSolution[i] != ReversedSolution[i] && CurrentSolution[i] != ReversedSolution[ReversedSolution.Length-1-i])
                {
                    reversedSolutionFound = false;
                }
            }
        }

        if (!solutionFound)
        {
            gemsReset = true;
            foreach (var gem in Gems)
            {
                //reset the gems
                gem.isActivated = false;
                FMODUnity.RuntimeManager.PlayOneShot("event:/Stingers/Fail Sound");
            }

            CurrentSolution = "";
        }
        
        if (CurrentSolution.Length > Solution.Length)
        {
            CurrentSolution = "";
        }
    }
    
    private static string ReverseString(string input)
{
	char[] inputChars = input.ToCharArray();
	Array.Reverse(inputChars);
	return new string(inputChars);
}

    public IEnumerator PlayStinger()
    {
        yield return new WaitForSeconds(1);
        FMODUnity.RuntimeManager.PlayOneShot("event:/Stingers/Stinger");
    }
    
    public IEnumerator PlayReverseStinger()
    {
        yield return new WaitForSeconds(1);
        FMODUnity.RuntimeManager.PlayOneShot("event:/Stingers/Stinger Reverse");
    }
}
