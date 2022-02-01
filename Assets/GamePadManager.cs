using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GamePadManager : MonoBehaviour
{
    public static GamePadManager instance;
    public bool Controller = false;

    private void Awake()
    {
        if (instance != null && instance != this)
        {
            Destroy(gameObject);
        } else {
            instance = this;
        }
    }

    void Update()
    {
        string[] names = Input.GetJoystickNames();

        for (int x = 0; x < names.Length; x++)
        {
            //print(names[x].Length);
            if (names[x].Length > 0)
            {
                print("CONTROLLER IS CONNECTED");
                Controller = true;
            }

            if (names[x].Length == 0)
            {
                print("No controller detected.");
                Controller = false;
            }
        }
    }
}
