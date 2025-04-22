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
  id 468
  arrival_time 8812.469420829553
  lifetime 548.7376417689753
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 13
    gpu 24
    rom 5
  ]
  node [
    id 1
    label "1"
    cpu 25
    gpu 44
    rom 38
  ]
  node [
    id 2
    label "2"
    cpu 36
    gpu 13
    rom 40
  ]
  node [
    id 3
    label "3"
    cpu 12
    gpu 10
    rom 41
  ]
  node [
    id 4
    label "4"
    cpu 42
    gpu 30
    rom 27
  ]
  node [
    id 5
    label "5"
    cpu 16
    gpu 11
    rom 49
  ]
  edge [
    source 0
    target 1
    bw 39
  ]
  edge [
    source 1
    target 2
    bw 34
  ]
  edge [
    source 2
    target 3
    bw 39
  ]
  edge [
    source 3
    target 4
    bw 46
  ]
  edge [
    source 4
    target 5
    bw 35
  ]
]
