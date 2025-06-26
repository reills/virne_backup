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
  id 1956
  arrival_time 42856.703075207355
  lifetime 3076.1047643653633
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 12
    gpu 32
    rom 33
  ]
  node [
    id 1
    label "1"
    cpu 30
    gpu 27
    rom 23
  ]
  node [
    id 2
    label "2"
    cpu 50
    gpu 24
    rom 15
  ]
  node [
    id 3
    label "3"
    cpu 9
    gpu 41
    rom 22
  ]
  node [
    id 4
    label "4"
    cpu 37
    gpu 7
    rom 14
  ]
  node [
    id 5
    label "5"
    cpu 50
    gpu 39
    rom 2
  ]
  node [
    id 6
    label "6"
    cpu 36
    gpu 35
    rom 10
  ]
  node [
    id 7
    label "7"
    cpu 33
    gpu 42
    rom 17
  ]
  node [
    id 8
    label "8"
    cpu 43
    gpu 13
    rom 14
  ]
  node [
    id 9
    label "9"
    cpu 19
    gpu 7
    rom 22
  ]
  edge [
    source 0
    target 1
    bw 29
  ]
  edge [
    source 1
    target 2
    bw 28
  ]
  edge [
    source 2
    target 3
    bw 24
  ]
  edge [
    source 3
    target 4
    bw 11
  ]
  edge [
    source 4
    target 5
    bw 1
  ]
  edge [
    source 5
    target 6
    bw 31
  ]
  edge [
    source 6
    target 7
    bw 50
  ]
  edge [
    source 7
    target 8
    bw 11
  ]
  edge [
    source 8
    target 9
    bw 31
  ]
]
