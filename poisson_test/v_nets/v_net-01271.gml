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
  id 1271
  arrival_time 26645.87580503668
  lifetime 2720.0345444572376
  num_nodes 5
  type "path"
  node [
    id 0
    label "0"
    cpu 46
    gpu 12
    rom 2
  ]
  node [
    id 1
    label "1"
    cpu 26
    gpu 28
    rom 49
  ]
  node [
    id 2
    label "2"
    cpu 50
    gpu 21
    rom 44
  ]
  node [
    id 3
    label "3"
    cpu 31
    gpu 43
    rom 29
  ]
  node [
    id 4
    label "4"
    cpu 33
    gpu 48
    rom 40
  ]
  edge [
    source 0
    target 1
    bw 40
  ]
  edge [
    source 1
    target 2
    bw 12
  ]
  edge [
    source 2
    target 3
    bw 21
  ]
  edge [
    source 3
    target 4
    bw 24
  ]
]
