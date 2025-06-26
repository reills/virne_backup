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
  id 799
  arrival_time 16648.9040876115
  lifetime 1978.885682511786
  num_nodes 8
  type "path"
  node [
    id 0
    label "0"
    cpu 6
    gpu 19
    rom 35
  ]
  node [
    id 1
    label "1"
    cpu 2
    gpu 29
    rom 34
  ]
  node [
    id 2
    label "2"
    cpu 31
    gpu 13
    rom 35
  ]
  node [
    id 3
    label "3"
    cpu 36
    gpu 31
    rom 29
  ]
  node [
    id 4
    label "4"
    cpu 43
    gpu 45
    rom 46
  ]
  node [
    id 5
    label "5"
    cpu 2
    gpu 27
    rom 5
  ]
  node [
    id 6
    label "6"
    cpu 4
    gpu 29
    rom 24
  ]
  node [
    id 7
    label "7"
    cpu 11
    gpu 28
    rom 9
  ]
  edge [
    source 0
    target 1
    bw 2
  ]
  edge [
    source 1
    target 2
    bw 12
  ]
  edge [
    source 2
    target 3
    bw 17
  ]
  edge [
    source 3
    target 4
    bw 19
  ]
  edge [
    source 4
    target 5
    bw 28
  ]
  edge [
    source 5
    target 6
    bw 20
  ]
  edge [
    source 6
    target 7
    bw 9
  ]
]
