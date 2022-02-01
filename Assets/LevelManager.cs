using FMODUnity;
using UnityEngine;
using UnityEngine.SceneManagement;

public class LevelManager : MonoBehaviour
{
    public static LevelManager instance;
    public bool HasLevelEnded;
    public Canvas LevelEndCanvas;
    
    // Start is called before the first frame update
    void Start()
    {
        
    }

    private void Awake()
    {
        if (instance != null && instance != this)
        {
            Destroy(gameObject);
        } 
        else 
        {
            instance = this;
        }
    }

    // Update is called once per frame
    void Update()
    {
        if (HasLevelEnded)
        {
            SceneManager.LoadScene(SceneManager.GetActiveScene().buildIndex + 1);
        }
    }
}
