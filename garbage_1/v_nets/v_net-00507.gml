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
  id 507
  arrival_time 9519.61225588767
  lifetime 1040.9330356146315
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 48
    gpu 37
    rom 39
  ]
  node [
    id 1
    label "1"
    cpu 44
    gpu 6
    rom 38
  ]
  node [
    id 2
    label "2"
    cpu 31
    gpu 26
    rom 3
  ]
  node [
    id 3
    label "3"
    cpu 21
    gpu 42
    rom 28
  ]
  node [
    id 4
    label "4"
    cpu 1
    gpu 28
    rom 30
  ]
  node [
    id 5
    label "5"
    cpu 28
    gpu 43
    rom 37
  ]
  edge [
    source 0
    target 1
    bw 30
  ]
  edge [
    source 1
    target 2
    bw 31
  ]
  edge [
    source 2
    target 3
    bw 19
  ]
  edge [
    source 3
    target 4
    bw 15
  ]
  edge [
    source 4
    target 5
    bw 49
  ]
]
