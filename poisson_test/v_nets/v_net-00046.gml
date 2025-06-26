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
  id 46
  arrival_time 920.4595429334229
  lifetime 520.2783908945878
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 0
    gpu 19
    rom 26
  ]
  node [
    id 1
    label "1"
    cpu 39
    gpu 28
    rom 49
  ]
  node [
    id 2
    label "2"
    cpu 2
    gpu 7
    rom 29
  ]
  node [
    id 3
    label "3"
    cpu 13
    gpu 38
    rom 0
  ]
  node [
    id 4
    label "4"
    cpu 41
    gpu 12
    rom 40
  ]
  node [
    id 5
    label "5"
    cpu 10
    gpu 22
    rom 38
  ]
  edge [
    source 0
    target 1
    bw 21
  ]
  edge [
    source 1
    target 2
    bw 36
  ]
  edge [
    source 2
    target 3
    bw 2
  ]
  edge [
    source 3
    target 4
    bw 3
  ]
  edge [
    source 4
    target 5
    bw 22
  ]
]
