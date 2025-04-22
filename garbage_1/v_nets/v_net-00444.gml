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
  id 444
  arrival_time 8564.319929747933
  lifetime 421.7039616513391
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 41
    gpu 46
    rom 27
  ]
  node [
    id 1
    label "1"
    cpu 48
    gpu 22
    rom 24
  ]
  node [
    id 2
    label "2"
    cpu 35
    gpu 25
    rom 41
  ]
  node [
    id 3
    label "3"
    cpu 11
    gpu 10
    rom 42
  ]
  node [
    id 4
    label "4"
    cpu 20
    gpu 39
    rom 12
  ]
  node [
    id 5
    label "5"
    cpu 27
    gpu 15
    rom 31
  ]
  edge [
    source 0
    target 1
    bw 0
  ]
  edge [
    source 1
    target 2
    bw 40
  ]
  edge [
    source 2
    target 3
    bw 21
  ]
  edge [
    source 3
    target 4
    bw 46
  ]
  edge [
    source 4
    target 5
    bw 27
  ]
]
