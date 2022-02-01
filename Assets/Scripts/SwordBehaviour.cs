using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SwordBehaviour : MonoBehaviour
{
	public Animator swordAnim;
	public EnemyBehaviour enemyBehaviour;
	public float damage;

	// Use this for initialization
	void Start ()
	{

		swordAnim = GetComponentInParent<Animator>();
		enemyBehaviour = FindObjectOfType<EnemyBehaviour>();

	}

	private void OnTriggerEnter(Collider other)
	{
		if (swordAnim.GetCurrentAnimatorStateInfo(0).IsName("slashing centered"))
		{
			Debug.Log("Animation is playing.");
			if (other.gameObject.CompareTag("Enemy"))
			{
				Debug.Log("Hit an enemy");
				enemyBehaviour.ApplyDamage(damage);
			}
		}
	}

	// Update is called once per frame
	void Update () {
		
	}
}
