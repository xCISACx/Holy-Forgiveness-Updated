using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EnemyBehaviour : MonoBehaviour
{

	public float HP = 10;
	public bool canBeDamaged;
	public float invulTime;

	// Use this for initialization
	void Start () {
		
	}
	
	// Update is called once per frame
	void Update ()
	{
		Death();
	}
	
	public void ApplyDamage(float dmg)
	{
		if (canBeDamaged)
		{
			HP -= dmg;
			StartCoroutine(JustDamaged());
		}
	}
						
	IEnumerator JustDamaged()
	{
		canBeDamaged = false;
		yield return new WaitForSeconds(invulTime);
		canBeDamaged = true;
	}

	public void Death()
	{
		if (HP <= 0)
		{
			Destroy(gameObject);
		}
	}

	private void OnCollisionEnter(Collision other)
	{
		if (other.gameObject.CompareTag("Projectile"))
		{
			ApplyDamage(1);
		}
	}
}
