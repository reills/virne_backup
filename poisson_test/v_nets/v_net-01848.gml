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
  id 1848
  arrival_time 40824.37881240536
  lifetime 334.47819142176144
  num_nodes 8
  type "path"
  node [
    id 0
    label "0"
    cpu 21
    gpu 36
    rom 39
  ]
  node [
    id 1
    label "1"
    cpu 16
    gpu 30
    rom 3
  ]
  node [
    id 2
    label "2"
    cpu 13
    gpu 9
    rom 22
  ]
  node [
    id 3
    label "3"
    cpu 3
    gpu 0
    rom 50
  ]
  node [
    id 4
    label "4"
    cpu 30
    gpu 0
    rom 11
  ]
  node [
    id 5
    label "5"
    cpu 48
    gpu 26
    rom 0
  ]
  node [
    id 6
    label "6"
    cpu 3
    gpu 29
    rom 22
  ]
  node [
    id 7
    label "7"
    cpu 11
    gpu 36
    rom 17
  ]
  edge [
    source 0
    target 1
    bw 9
  ]
  edge [
    source 1
    target 2
    bw 40
  ]
  edge [
    source 2
    target 3
    bw 23
  ]
  edge [
    source 3
    target 4
    bw 38
  ]
  edge [
    source 4
    target 5
    bw 0
  ]
  edge [
    source 5
    target 6
    bw 20
  ]
  edge [
    source 6
    target 7
    bw 46
  ]
]
