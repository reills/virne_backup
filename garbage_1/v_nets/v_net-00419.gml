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
  id 419
  arrival_time 8252.258758051606
  lifetime 4249.6956855233875
  num_nodes 5
  type "path"
  node [
    id 0
    label "0"
    cpu 40
    gpu 35
    rom 14
  ]
  node [
    id 1
    label "1"
    cpu 12
    gpu 1
    rom 3
  ]
  node [
    id 2
    label "2"
    cpu 12
    gpu 1
    rom 46
  ]
  node [
    id 3
    label "3"
    cpu 27
    gpu 1
    rom 29
  ]
  node [
    id 4
    label "4"
    cpu 6
    gpu 11
    rom 10
  ]
  edge [
    source 0
    target 1
    bw 17
  ]
  edge [
    source 1
    target 2
    bw 4
  ]
  edge [
    source 2
    target 3
    bw 36
  ]
  edge [
    source 3
    target 4
    bw 24
  ]
]
