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
  id 1142
  arrival_time 23860.806600400963
  lifetime 1366.0840771610438
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 48
    gpu 43
    rom 32
  ]
  node [
    id 1
    label "1"
    cpu 25
    gpu 15
    rom 11
  ]
  node [
    id 2
    label "2"
    cpu 10
    gpu 6
    rom 22
  ]
  node [
    id 3
    label "3"
    cpu 23
    gpu 30
    rom 49
  ]
  node [
    id 4
    label "4"
    cpu 30
    gpu 28
    rom 17
  ]
  node [
    id 5
    label "5"
    cpu 22
    gpu 20
    rom 48
  ]
  edge [
    source 0
    target 1
    bw 38
  ]
  edge [
    source 1
    target 2
    bw 15
  ]
  edge [
    source 2
    target 3
    bw 46
  ]
  edge [
    source 3
    target 4
    bw 0
  ]
  edge [
    source 4
    target 5
    bw 42
  ]
]
