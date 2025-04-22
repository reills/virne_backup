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
  id 1299
  arrival_time 27105.113766449533
  lifetime 2319.4845696895372
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 12
    gpu 12
    rom 10
  ]
  node [
    id 1
    label "1"
    cpu 16
    gpu 32
    rom 30
  ]
  node [
    id 2
    label "2"
    cpu 8
    gpu 43
    rom 27
  ]
  node [
    id 3
    label "3"
    cpu 47
    gpu 42
    rom 20
  ]
  node [
    id 4
    label "4"
    cpu 42
    gpu 3
    rom 23
  ]
  node [
    id 5
    label "5"
    cpu 26
    gpu 12
    rom 29
  ]
  edge [
    source 0
    target 1
    bw 22
  ]
  edge [
    source 1
    target 2
    bw 12
  ]
  edge [
    source 2
    target 3
    bw 41
  ]
  edge [
    source 3
    target 4
    bw 21
  ]
  edge [
    source 4
    target 5
    bw 0
  ]
]
