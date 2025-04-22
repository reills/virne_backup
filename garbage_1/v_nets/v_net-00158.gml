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
  id 158
  arrival_time 3024.9930115328075
  lifetime 346.85440019571985
  num_nodes 9
  type "path"
  node [
    id 0
    label "0"
    cpu 1
    gpu 22
    rom 22
  ]
  node [
    id 1
    label "1"
    cpu 19
    gpu 39
    rom 28
  ]
  node [
    id 2
    label "2"
    cpu 11
    gpu 41
    rom 29
  ]
  node [
    id 3
    label "3"
    cpu 49
    gpu 16
    rom 33
  ]
  node [
    id 4
    label "4"
    cpu 35
    gpu 38
    rom 42
  ]
  node [
    id 5
    label "5"
    cpu 18
    gpu 11
    rom 25
  ]
  node [
    id 6
    label "6"
    cpu 7
    gpu 30
    rom 9
  ]
  node [
    id 7
    label "7"
    cpu 45
    gpu 11
    rom 42
  ]
  node [
    id 8
    label "8"
    cpu 49
    gpu 8
    rom 39
  ]
  edge [
    source 0
    target 1
    bw 41
  ]
  edge [
    source 1
    target 2
    bw 16
  ]
  edge [
    source 2
    target 3
    bw 26
  ]
  edge [
    source 3
    target 4
    bw 43
  ]
  edge [
    source 4
    target 5
    bw 17
  ]
  edge [
    source 5
    target 6
    bw 18
  ]
  edge [
    source 6
    target 7
    bw 43
  ]
  edge [
    source 7
    target 8
    bw 20
  ]
]
