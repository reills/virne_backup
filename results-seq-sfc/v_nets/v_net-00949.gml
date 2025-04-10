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
  id 949
  arrival_time 20278.038188699556
  lifetime 94.75540934216124
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 23
    gpu 10
    rom 5
  ]
  node [
    id 1
    label "1"
    cpu 16
    gpu 11
    rom 33
  ]
  node [
    id 2
    label "2"
    cpu 26
    gpu 26
    rom 11
  ]
  node [
    id 3
    label "3"
    cpu 22
    gpu 46
    rom 30
  ]
  node [
    id 4
    label "4"
    cpu 33
    gpu 46
    rom 45
  ]
  node [
    id 5
    label "5"
    cpu 14
    gpu 14
    rom 35
  ]
  edge [
    source 0
    target 1
    bw 25
  ]
  edge [
    source 1
    target 2
    bw 50
  ]
  edge [
    source 2
    target 3
    bw 11
  ]
  edge [
    source 3
    target 4
    bw 42
  ]
  edge [
    source 4
    target 5
    bw 49
  ]
]
