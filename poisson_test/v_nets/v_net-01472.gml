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
  id 1472
  arrival_time 32036.25424960057
  lifetime 1104.9357041181631
  num_nodes 14
  type "path"
  node [
    id 0
    label "0"
    cpu 23
    gpu 26
    rom 31
  ]
  node [
    id 1
    label "1"
    cpu 5
    gpu 9
    rom 10
  ]
  node [
    id 2
    label "2"
    cpu 35
    gpu 36
    rom 4
  ]
  node [
    id 3
    label "3"
    cpu 43
    gpu 14
    rom 35
  ]
  node [
    id 4
    label "4"
    cpu 4
    gpu 20
    rom 40
  ]
  node [
    id 5
    label "5"
    cpu 39
    gpu 24
    rom 39
  ]
  node [
    id 6
    label "6"
    cpu 18
    gpu 33
    rom 7
  ]
  node [
    id 7
    label "7"
    cpu 15
    gpu 9
    rom 31
  ]
  node [
    id 8
    label "8"
    cpu 44
    gpu 35
    rom 35
  ]
  node [
    id 9
    label "9"
    cpu 45
    gpu 2
    rom 32
  ]
  node [
    id 10
    label "10"
    cpu 43
    gpu 1
    rom 14
  ]
  node [
    id 11
    label "11"
    cpu 36
    gpu 42
    rom 19
  ]
  node [
    id 12
    label "12"
    cpu 42
    gpu 37
    rom 30
  ]
  node [
    id 13
    label "13"
    cpu 11
    gpu 28
    rom 12
  ]
  edge [
    source 0
    target 1
    bw 0
  ]
  edge [
    source 1
    target 2
    bw 7
  ]
  edge [
    source 2
    target 3
    bw 46
  ]
  edge [
    source 3
    target 4
    bw 14
  ]
  edge [
    source 4
    target 5
    bw 31
  ]
  edge [
    source 5
    target 6
    bw 35
  ]
  edge [
    source 6
    target 7
    bw 17
  ]
  edge [
    source 7
    target 8
    bw 49
  ]
  edge [
    source 8
    target 9
    bw 24
  ]
  edge [
    source 9
    target 10
    bw 40
  ]
  edge [
    source 10
    target 11
    bw 33
  ]
  edge [
    source 11
    target 12
    bw 27
  ]
  edge [
    source 12
    target 13
    bw 15
  ]
]
