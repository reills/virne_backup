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
  id 733
  arrival_time 15355.612633434299
  lifetime 723.0287438760048
  num_nodes 4
  type "path"
  node [
    id 0
    label "0"
    cpu 25
    gpu 15
    rom 14
  ]
  node [
    id 1
    label "1"
    cpu 31
    gpu 8
    rom 11
  ]
  node [
    id 2
    label "2"
    cpu 33
    gpu 0
    rom 47
  ]
  node [
    id 3
    label "3"
    cpu 6
    gpu 2
    rom 7
  ]
  edge [
    source 0
    target 1
    bw 10
  ]
  edge [
    source 1
    target 2
    bw 41
  ]
  edge [
    source 2
    target 3
    bw 32
  ]
]
