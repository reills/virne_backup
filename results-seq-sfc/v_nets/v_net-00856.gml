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
  id 856
  arrival_time 17703.62394485629
  lifetime 593.6488887345263
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 5
    gpu 49
    rom 17
  ]
  node [
    id 1
    label "1"
    cpu 11
    gpu 23
    rom 0
  ]
  node [
    id 2
    label "2"
    cpu 17
    gpu 24
    rom 6
  ]
  node [
    id 3
    label "3"
    cpu 1
    gpu 27
    rom 38
  ]
  node [
    id 4
    label "4"
    cpu 11
    gpu 0
    rom 37
  ]
  node [
    id 5
    label "5"
    cpu 27
    gpu 4
    rom 35
  ]
  edge [
    source 0
    target 1
    bw 35
  ]
  edge [
    source 1
    target 2
    bw 22
  ]
  edge [
    source 2
    target 3
    bw 26
  ]
  edge [
    source 3
    target 4
    bw 32
  ]
  edge [
    source 4
    target 5
    bw 13
  ]
]
