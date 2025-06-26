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
  id 406
  arrival_time 8034.990215802832
  lifetime 217.54296742266726
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 30
    gpu 48
    rom 27
  ]
  node [
    id 1
    label "1"
    cpu 40
    gpu 13
    rom 39
  ]
  node [
    id 2
    label "2"
    cpu 10
    gpu 23
    rom 0
  ]
  node [
    id 3
    label "3"
    cpu 24
    gpu 40
    rom 6
  ]
  node [
    id 4
    label "4"
    cpu 12
    gpu 17
    rom 18
  ]
  node [
    id 5
    label "5"
    cpu 42
    gpu 3
    rom 10
  ]
  edge [
    source 0
    target 1
    bw 8
  ]
  edge [
    source 1
    target 2
    bw 33
  ]
  edge [
    source 2
    target 3
    bw 18
  ]
  edge [
    source 3
    target 4
    bw 15
  ]
  edge [
    source 4
    target 5
    bw 8
  ]
]
