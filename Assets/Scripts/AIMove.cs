using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;

public class AIMove : MonoBehaviour
{

	public Transform destination;
	public NavMeshAgent navMeshAgent;
 
	// Use this for initialization
	void Start ()
	{
		if (navMeshAgent == null)
		{
			navMeshAgent = GetComponentInChildren<NavMeshAgent>();
		}
	}

	private void Update()
	{
		if (destination != null)
		{
			navMeshAgent.transform.LookAt(new Vector3(destination.position.x, destination.position.y, 0));
		}
		
		if (navMeshAgent == null)
		{
			Debug.LogError("A nav mesh agent component isn't attached to " + gameObject.name);
		}
		else
		{
			SetDestination();
		}
	}

	void SetDestination()
	{
		if (destination != null && navMeshAgent != null)
		{
			if (navMeshAgent.isActiveAndEnabled)
			{
				Vector3 targetVector = destination.transform.position;
				navMeshAgent.SetDestination(targetVector);
			}
		}
		else if (navMeshAgent == null)
		{
			Debug.Log("No target");
		}
	}
}
