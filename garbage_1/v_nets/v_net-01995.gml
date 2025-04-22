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
  id 1995
  arrival_time 43504.88121473157
  lifetime 127.56336874646809
  num_nodes 5
  type "path"
  node [
    id 0
    label "0"
    cpu 20
    gpu 24
    rom 2
  ]
  node [
    id 1
    label "1"
    cpu 41
    gpu 10
    rom 35
  ]
  node [
    id 2
    label "2"
    cpu 14
    gpu 17
    rom 35
  ]
  node [
    id 3
    label "3"
    cpu 49
    gpu 18
    rom 22
  ]
  node [
    id 4
    label "4"
    cpu 38
    gpu 7
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
    bw 8
  ]
  edge [
    source 2
    target 3
    bw 42
  ]
  edge [
    source 3
    target 4
    bw 38
  ]
]
