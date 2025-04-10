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
  id 374
  arrival_time 7032.790018556675
  lifetime 2684.349712036998
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 1
    gpu 5
    rom 42
  ]
  node [
    id 1
    label "1"
    cpu 20
    gpu 11
    rom 13
  ]
  node [
    id 2
    label "2"
    cpu 34
    gpu 6
    rom 22
  ]
  node [
    id 3
    label "3"
    cpu 20
    gpu 48
    rom 12
  ]
  node [
    id 4
    label "4"
    cpu 1
    gpu 12
    rom 28
  ]
  node [
    id 5
    label "5"
    cpu 13
    gpu 3
    rom 44
  ]
  edge [
    source 0
    target 1
    bw 33
  ]
  edge [
    source 1
    target 2
    bw 41
  ]
  edge [
    source 2
    target 3
    bw 18
  ]
  edge [
    source 3
    target 4
    bw 1
  ]
  edge [
    source 4
    target 5
    bw 49
  ]
]
