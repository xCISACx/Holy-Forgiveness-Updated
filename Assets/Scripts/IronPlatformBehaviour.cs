using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class IronPlatformBehaviour : MonoBehaviour
{

	public Animator anim;
	public Animator lavaAnim;
	public GameManager gameManager;
	public float yPosition;
	public float originalHeight;
	public float modifiedHeight;
	public YuutaPlayerBehaviour Yuuta;
	public FMOD.Studio.EventInstance PlaySlidingSound;
	
	// Start is called before the first frame update
	void Start()
	{
		anim = GetComponent<Animator>();
		this.gameObject.GetComponent<Rigidbody>().isKinematic = true;
		gameManager = FindObjectOfType<GameManager>();
		yPosition = transform.position.y;
		originalHeight = yPosition;
		modifiedHeight = originalHeight + 1;
		Yuuta = FindObjectOfType<YuutaPlayerBehaviour>();
		PlaySlidingSound = FMODUnity.RuntimeManager.CreateInstance("event:/SFX/Environment/Cubes/Sliding");
	}

	// Update is called once per frame
	void FixedUpdate()
	{
		anim.SetBool("lava up", gameManager.lavaRaised);
		anim.SetBool("lava down", !gameManager.lavaRaised);
	}

	void Update()
	{
		yPosition = transform.position.y;
		//UpdatePosition();
		Yuuta = FindObjectOfType<YuutaPlayerBehaviour>();
	}

	private void OnCollisionStay(Collision other)
	{
		if (other.gameObject.CompareTag("Yuuta"))
		{
			if (Input.GetButton("R1") || Input.GetMouseButton(1))
			{
				Yuuta.GetComponent<Animator>().SetBool("pushed", true);
				StartCoroutine(WaitBeforeChangingAnimation());
				anim.enabled = true;
				anim.SetBool("pushed", true);
				if (!gameManager.lavaRaised)
				{
					anim.SetBool("lava down", true);
					//yPosition = originalHeight;
				}
				else if (gameManager.lavaRaised)
				{
					anim.SetBool("lava down", false);
					//yPosition = modifiedHeight;
				}
			}
		}
	}

	/*private void OnTriggerStay(Collider other)
	{
		if (other.gameObject.CompareTag("Stopper"))
		{
			anim.enabled = false;	
			
			if (!gameManager.lavaRaised)
			{
				anim.SetBool("lava down", true);
				yPosition = transform.position.y;
				yPosition = originalHeight;
			}
			else if (gameManager.lavaRaised)
			{
				anim.SetBool("lava down", false);
				yPosition = transform.position.y;
				yPosition += yPosition;
			}
		}
	}*/

	/*public void UpdatePosition()
	{
		if (anim.GetBool("lava down"))
		{
			yPosition = originalHeight;
			Debug.Log("moving platform down");
		}

		if (anim.GetBool("lava up"))
		{
			yPosition = modifiedHeight;
			Debug.Log("moving platform up");
		}
	}*/

	public void PlaySplashSound()
	{
		FMODUnity.RuntimeManager.PlayOneShot("event:/SFX/Environment/Lava/Lava Splash");
	}

	public void PlaySlidingAudio()
	{
		PlaySlidingSound.start();
	}
	
	public void StopSlidingAudio()
	{
		PlaySlidingSound.stop(FMOD.Studio.STOP_MODE.ALLOWFADEOUT);
	}
	
	IEnumerator WaitBeforeChangingAnimation()
	{
		yield return new WaitForSeconds(0.8f);
		Yuuta.GetComponent<Animator>().SetBool("pushed", false);
	}
}
