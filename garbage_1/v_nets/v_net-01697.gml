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
  id 1697
  arrival_time 37685.30275874859
  lifetime 304.3488947595658
  num_nodes 11
  type "path"
  node [
    id 0
    label "0"
    cpu 9
    gpu 32
    rom 7
  ]
  node [
    id 1
    label "1"
    cpu 9
    gpu 44
    rom 34
  ]
  node [
    id 2
    label "2"
    cpu 2
    gpu 46
    rom 27
  ]
  node [
    id 3
    label "3"
    cpu 25
    gpu 32
    rom 38
  ]
  node [
    id 4
    label "4"
    cpu 8
    gpu 21
    rom 32
  ]
  node [
    id 5
    label "5"
    cpu 6
    gpu 39
    rom 30
  ]
  node [
    id 6
    label "6"
    cpu 13
    gpu 18
    rom 11
  ]
  node [
    id 7
    label "7"
    cpu 36
    gpu 5
    rom 16
  ]
  node [
    id 8
    label "8"
    cpu 27
    gpu 42
    rom 33
  ]
  node [
    id 9
    label "9"
    cpu 37
    gpu 3
    rom 19
  ]
  node [
    id 10
    label "10"
    cpu 37
    gpu 27
    rom 8
  ]
  edge [
    source 0
    target 1
    bw 14
  ]
  edge [
    source 1
    target 2
    bw 43
  ]
  edge [
    source 2
    target 3
    bw 42
  ]
  edge [
    source 3
    target 4
    bw 33
  ]
  edge [
    source 4
    target 5
    bw 19
  ]
  edge [
    source 5
    target 6
    bw 31
  ]
  edge [
    source 6
    target 7
    bw 36
  ]
  edge [
    source 7
    target 8
    bw 45
  ]
  edge [
    source 8
    target 9
    bw 13
  ]
  edge [
    source 9
    target 10
    bw 24
  ]
]
