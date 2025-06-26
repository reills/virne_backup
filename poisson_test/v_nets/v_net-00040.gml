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
  id 40
  arrival_time 762.5146618444509
  lifetime 403.21928318727964
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 36
    gpu 31
    rom 32
  ]
  node [
    id 1
    label "1"
    cpu 48
    gpu 22
    rom 27
  ]
  node [
    id 2
    label "2"
    cpu 47
    gpu 0
    rom 23
  ]
  node [
    id 3
    label "3"
    cpu 21
    gpu 12
    rom 40
  ]
  node [
    id 4
    label "4"
    cpu 10
    gpu 31
    rom 45
  ]
  node [
    id 5
    label "5"
    cpu 36
    gpu 49
    rom 11
  ]
  node [
    id 6
    label "6"
    cpu 4
    gpu 9
    rom 36
  ]
  edge [
    source 0
    target 1
    bw 43
  ]
  edge [
    source 1
    target 2
    bw 44
  ]
  edge [
    source 2
    target 3
    bw 0
  ]
  edge [
    source 3
    target 4
    bw 22
  ]
  edge [
    source 4
    target 5
    bw 10
  ]
  edge [
    source 5
    target 6
    bw 26
  ]
]
