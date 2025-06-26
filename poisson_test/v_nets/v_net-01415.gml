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
  id 1415
  arrival_time 29649.78192293923
  lifetime 295.8820063244982
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 23
    gpu 0
    rom 46
  ]
  node [
    id 1
    label "1"
    cpu 15
    gpu 5
    rom 29
  ]
  node [
    id 2
    label "2"
    cpu 1
    gpu 29
    rom 49
  ]
  node [
    id 3
    label "3"
    cpu 5
    gpu 6
    rom 49
  ]
  node [
    id 4
    label "4"
    cpu 30
    gpu 9
    rom 23
  ]
  node [
    id 5
    label "5"
    cpu 0
    gpu 15
    rom 19
  ]
  node [
    id 6
    label "6"
    cpu 38
    gpu 4
    rom 49
  ]
  node [
    id 7
    label "7"
    cpu 13
    gpu 13
    rom 36
  ]
  node [
    id 8
    label "8"
    cpu 46
    gpu 27
    rom 8
  ]
  node [
    id 9
    label "9"
    cpu 8
    gpu 9
    rom 12
  ]
  node [
    id 10
    label "10"
    cpu 47
    gpu 23
    rom 10
  ]
  node [
    id 11
    label "11"
    cpu 5
    gpu 26
    rom 26
  ]
  node [
    id 12
    label "12"
    cpu 22
    gpu 3
    rom 9
  ]
  edge [
    source 0
    target 1
    bw 24
  ]
  edge [
    source 1
    target 2
    bw 48
  ]
  edge [
    source 2
    target 3
    bw 20
  ]
  edge [
    source 3
    target 4
    bw 12
  ]
  edge [
    source 4
    target 5
    bw 14
  ]
  edge [
    source 5
    target 6
    bw 25
  ]
  edge [
    source 6
    target 7
    bw 26
  ]
  edge [
    source 7
    target 8
    bw 50
  ]
  edge [
    source 8
    target 9
    bw 0
  ]
  edge [
    source 9
    target 10
    bw 43
  ]
  edge [
    source 10
    target 11
    bw 23
  ]
  edge [
    source 11
    target 12
    bw 6
  ]
]
