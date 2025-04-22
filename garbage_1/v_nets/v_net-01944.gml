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
  id 1944
  arrival_time 42787.77977943435
  lifetime 350.66298040176764
  num_nodes 9
  type "path"
  node [
    id 0
    label "0"
    cpu 5
    gpu 1
    rom 3
  ]
  node [
    id 1
    label "1"
    cpu 28
    gpu 11
    rom 0
  ]
  node [
    id 2
    label "2"
    cpu 25
    gpu 7
    rom 13
  ]
  node [
    id 3
    label "3"
    cpu 9
    gpu 41
    rom 33
  ]
  node [
    id 4
    label "4"
    cpu 15
    gpu 31
    rom 24
  ]
  node [
    id 5
    label "5"
    cpu 25
    gpu 29
    rom 46
  ]
  node [
    id 6
    label "6"
    cpu 49
    gpu 20
    rom 44
  ]
  node [
    id 7
    label "7"
    cpu 48
    gpu 28
    rom 20
  ]
  node [
    id 8
    label "8"
    cpu 13
    gpu 28
    rom 49
  ]
  edge [
    source 0
    target 1
    bw 17
  ]
  edge [
    source 1
    target 2
    bw 33
  ]
  edge [
    source 2
    target 3
    bw 4
  ]
  edge [
    source 3
    target 4
    bw 38
  ]
  edge [
    source 4
    target 5
    bw 32
  ]
  edge [
    source 5
    target 6
    bw 18
  ]
  edge [
    source 6
    target 7
    bw 32
  ]
  edge [
    source 7
    target 8
    bw 29
  ]
]
