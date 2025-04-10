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
  id 900
  arrival_time 19302.563752048485
  lifetime 3664.892543332474
  num_nodes 11
  type "path"
  node [
    id 0
    label "0"
    cpu 39
    gpu 47
    rom 19
  ]
  node [
    id 1
    label "1"
    cpu 27
    gpu 22
    rom 49
  ]
  node [
    id 2
    label "2"
    cpu 5
    gpu 27
    rom 48
  ]
  node [
    id 3
    label "3"
    cpu 27
    gpu 23
    rom 20
  ]
  node [
    id 4
    label "4"
    cpu 22
    gpu 5
    rom 37
  ]
  node [
    id 5
    label "5"
    cpu 15
    gpu 20
    rom 45
  ]
  node [
    id 6
    label "6"
    cpu 32
    gpu 14
    rom 39
  ]
  node [
    id 7
    label "7"
    cpu 46
    gpu 18
    rom 29
  ]
  node [
    id 8
    label "8"
    cpu 22
    gpu 8
    rom 19
  ]
  node [
    id 9
    label "9"
    cpu 9
    gpu 49
    rom 34
  ]
  node [
    id 10
    label "10"
    cpu 0
    gpu 4
    rom 3
  ]
  edge [
    source 0
    target 1
    bw 38
  ]
  edge [
    source 1
    target 2
    bw 27
  ]
  edge [
    source 2
    target 3
    bw 30
  ]
  edge [
    source 3
    target 4
    bw 8
  ]
  edge [
    source 4
    target 5
    bw 4
  ]
  edge [
    source 5
    target 6
    bw 42
  ]
  edge [
    source 6
    target 7
    bw 23
  ]
  edge [
    source 7
    target 8
    bw 37
  ]
  edge [
    source 8
    target 9
    bw 42
  ]
  edge [
    source 9
    target 10
    bw 9
  ]
]
