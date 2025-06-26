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
  id 1386
  arrival_time 29323.51563683668
  lifetime 1132.192972425698
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 49
    gpu 23
    rom 15
  ]
  node [
    id 1
    label "1"
    cpu 2
    gpu 4
    rom 25
  ]
  node [
    id 2
    label "2"
    cpu 22
    gpu 24
    rom 39
  ]
  node [
    id 3
    label "3"
    cpu 45
    gpu 47
    rom 41
  ]
  node [
    id 4
    label "4"
    cpu 40
    gpu 47
    rom 36
  ]
  node [
    id 5
    label "5"
    cpu 42
    gpu 44
    rom 31
  ]
  edge [
    source 0
    target 1
    bw 30
  ]
  edge [
    source 1
    target 2
    bw 5
  ]
  edge [
    source 2
    target 3
    bw 0
  ]
  edge [
    source 3
    target 4
    bw 30
  ]
  edge [
    source 4
    target 5
    bw 42
  ]
]
