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
  id 1558
  arrival_time 34915.64977684797
  lifetime 286.322689967612
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 13
    gpu 7
    rom 39
  ]
  node [
    id 1
    label "1"
    cpu 42
    gpu 45
    rom 32
  ]
  node [
    id 2
    label "2"
    cpu 46
    gpu 10
    rom 49
  ]
  node [
    id 3
    label "3"
    cpu 32
    gpu 34
    rom 39
  ]
  node [
    id 4
    label "4"
    cpu 16
    gpu 29
    rom 50
  ]
  node [
    id 5
    label "5"
    cpu 17
    gpu 37
    rom 14
  ]
  edge [
    source 0
    target 1
    bw 35
  ]
  edge [
    source 1
    target 2
    bw 13
  ]
  edge [
    source 2
    target 3
    bw 16
  ]
  edge [
    source 3
    target 4
    bw 32
  ]
  edge [
    source 4
    target 5
    bw 7
  ]
]
