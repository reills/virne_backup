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
  id 495
  arrival_time 9306.93239321786
  lifetime 824.952615021342
  num_nodes 5
  type "path"
  node [
    id 0
    label "0"
    cpu 1
    gpu 17
    rom 17
  ]
  node [
    id 1
    label "1"
    cpu 15
    gpu 9
    rom 47
  ]
  node [
    id 2
    label "2"
    cpu 14
    gpu 4
    rom 1
  ]
  node [
    id 3
    label "3"
    cpu 11
    gpu 28
    rom 37
  ]
  node [
    id 4
    label "4"
    cpu 44
    gpu 33
    rom 6
  ]
  edge [
    source 0
    target 1
    bw 30
  ]
  edge [
    source 1
    target 2
    bw 49
  ]
  edge [
    source 2
    target 3
    bw 29
  ]
  edge [
    source 3
    target 4
    bw 21
  ]
]
