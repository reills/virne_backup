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
  id 451
  arrival_time 8626.34684011397
  lifetime 1363.4364596323292
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 7
    gpu 5
    rom 38
  ]
  node [
    id 1
    label "1"
    cpu 2
    gpu 19
    rom 7
  ]
  node [
    id 2
    label "2"
    cpu 26
    gpu 29
    rom 40
  ]
  node [
    id 3
    label "3"
    cpu 3
    gpu 33
    rom 27
  ]
  node [
    id 4
    label "4"
    cpu 40
    gpu 35
    rom 41
  ]
  node [
    id 5
    label "5"
    cpu 23
    gpu 46
    rom 49
  ]
  node [
    id 6
    label "6"
    cpu 32
    gpu 28
    rom 31
  ]
  edge [
    source 0
    target 1
    bw 8
  ]
  edge [
    source 1
    target 2
    bw 18
  ]
  edge [
    source 2
    target 3
    bw 8
  ]
  edge [
    source 3
    target 4
    bw 15
  ]
  edge [
    source 4
    target 5
    bw 47
  ]
  edge [
    source 5
    target 6
    bw 39
  ]
]
