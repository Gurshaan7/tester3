module problem_sample::DataStructure{
    use std::debug;
    use std::vector;

    //ERROR
    const NOT_ENOUGH_ELEMENT:u64 = 1;

    struct DataStructure has store,key,drop,copy{
        arr : vector<u64> ,
        arr_max : vector<u64>
    }

    //push operation of our DataStructure

    public fun push_operation(ds : &mut DataStructure,element : u64)
    {
        let current_size = vector::length(&ds.arr);
        vector::push_back(&mut ds.arr,element );
        if(current_size==0)
        {
            vector::push_back(&mut ds.arr_max,element );
        }

        else
        {
            let n=current_size-1;
            let arr_max_top_element = *vector::borrow(&mut ds.arr_max,(n as u64));
            if(arr_max_top_element < element)
            {
                vector::push_back(&mut ds.arr_max,element );   
            }
            else
            {

                vector::push_back(&mut ds.arr_max,arr_max_top_element);
            };

        };
    }

    //pop operation of our DataStructure

    public fun pop_operation(ds: &mut DataStructure)
    {
        let current_size = vector::length(&ds.arr);
        assert!(current_size!=0,NOT_ENOUGH_ELEMENT);
        vector::pop_back(&mut ds.arr_max);
        vector::pop_back(&mut ds.arr);
    }

    //return maximum element in O(1) complexity
    public fun max_element(ds: &mut DataStructure) :u64{
        let current_size = vector::length(&ds.arr);
        assert!(current_size!=0,NOT_ENOUGH_ELEMENT);
        let n=current_size-1;
        let arr_max_top_element = *vector::borrow(&mut ds.arr_max,(n as u64));
        return arr_max_top_element
    }

    #[test]
    fun testing()
    {
        let ds = DataStructure{
            arr:vector::empty<u64>(),
            arr_max :vector::empty<u64>(),
        };

        push_operation(&mut ds,2);
        push_operation(&mut ds,5);
        push_operation(&mut ds,4);
        push_operation(&mut ds,1);
        push_operation(&mut ds,10);
        push_operation(&mut ds,7);
        
        let x=max_element(&mut ds);
        debug::print(&x);

        push_operation(&mut ds,11);
        pop_operation(&mut ds);
        pop_operation(&mut ds);
        pop_operation(&mut ds);
        
        let x=max_element(&mut ds);
        debug::print(&x);
    }
}