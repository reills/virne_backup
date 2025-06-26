graph [
  node_attrs_setting [
    name "cpu"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "node"
    type "resource"
  ]
  node_attrs_setting [
    name "gpu"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "node"
    type "resource"
  ]
  node_attrs_setting [
    name "rom"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "node"
    type "resource"
  ]
  link_attrs_setting "_networkx_list_start"
  link_attrs_setting [
    name "bw"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "link"
    type "resource"
  ]
  id 1945
  arrival_time 42790.47120112677
  lifetime 107.24252303038956
  num_nodes 12
  type "path"
  node [
    id 0
    label "0"
    cpu 22
    gpu 39
    rom 13
  ]
  node [
    id 1
    label "1"
    cpu 50
    gpu 18
    rom 17
  ]
  node [
    id 2
    label "2"
    cpu 7
    gpu 32
    rom 17
  ]
  node [
    id 3
    label "3"
    cpu 8
    gpu 8
    rom 45
  ]
  node [
    id 4
    label "4"
    cpu 27
    gpu 21
    rom 1
  ]
  node [
    id 5
    label "5"
    cpu 27
    gpu 11
    rom 4
  ]
  node [
    id 6
    label "6"
    cpu 3
    gpu 34
    rom 14
  ]
  node [
    id 7
    label "7"
    cpu 12
    gpu 22
    rom 35
  ]
  node [
    id 8
    label "8"
    cpu 15
    gpu 10
    rom 48
  ]
  node [
    id 9
    label "9"
    cpu 49
    gpu 21
    rom 35
  ]
  node [
    id 10
    label "10"
    cpu 19
    gpu 50
    rom 40
  ]
  node [
    id 11
    label "11"
    cpu 47
    gpu 50
    rom 16
  ]
  edge [
    source 0
    target 1
    bw 39
  ]
  edge [
    source 1
    target 2
    bw 25
  ]
  edge [
    source 2
    target 3
    bw 50
  ]
  edge [
    source 3
    target 4
    bw 48
  ]
  edge [
    source 4
    target 5
    bw 8
  ]
  edge [
    source 5
    target 6
    bw 33
  ]
  edge [
    source 6
    target 7
    bw 31
  ]
  edge [
    source 7
    target 8
    bw 21
  ]
  edge [
    source 8
    target 9
    bw 21
  ]
  edge [
    source 9
    target 10
    bw 7
  ]
  edge [
    source 10
    target 11
    bw 47
  ]
]
