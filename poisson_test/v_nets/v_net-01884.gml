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
  id 1884
  arrival_time 41508.4206650167
  lifetime 117.0181074836539
  num_nodes 9
  type "path"
  node [
    id 0
    label "0"
    cpu 35
    gpu 41
    rom 22
  ]
  node [
    id 1
    label "1"
    cpu 47
    gpu 31
    rom 28
  ]
  node [
    id 2
    label "2"
    cpu 49
    gpu 23
    rom 41
  ]
  node [
    id 3
    label "3"
    cpu 19
    gpu 27
    rom 16
  ]
  node [
    id 4
    label "4"
    cpu 46
    gpu 50
    rom 27
  ]
  node [
    id 5
    label "5"
    cpu 28
    gpu 27
    rom 26
  ]
  node [
    id 6
    label "6"
    cpu 13
    gpu 1
    rom 40
  ]
  node [
    id 7
    label "7"
    cpu 1
    gpu 3
    rom 34
  ]
  node [
    id 8
    label "8"
    cpu 17
    gpu 30
    rom 29
  ]
  edge [
    source 0
    target 1
    bw 28
  ]
  edge [
    source 1
    target 2
    bw 27
  ]
  edge [
    source 2
    target 3
    bw 41
  ]
  edge [
    source 3
    target 4
    bw 2
  ]
  edge [
    source 4
    target 5
    bw 1
  ]
  edge [
    source 5
    target 6
    bw 49
  ]
  edge [
    source 6
    target 7
    bw 5
  ]
  edge [
    source 7
    target 8
    bw 13
  ]
]
