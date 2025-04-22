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
  id 1356
  arrival_time 28652.88957265613
  lifetime 418.49885648848806
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 7
    gpu 41
    rom 10
  ]
  node [
    id 1
    label "1"
    cpu 22
    gpu 4
    rom 30
  ]
  node [
    id 2
    label "2"
    cpu 25
    gpu 0
    rom 30
  ]
  node [
    id 3
    label "3"
    cpu 30
    gpu 19
    rom 46
  ]
  node [
    id 4
    label "4"
    cpu 22
    gpu 26
    rom 49
  ]
  node [
    id 5
    label "5"
    cpu 43
    gpu 7
    rom 46
  ]
  edge [
    source 0
    target 1
    bw 40
  ]
  edge [
    source 1
    target 2
    bw 36
  ]
  edge [
    source 2
    target 3
    bw 45
  ]
  edge [
    source 3
    target 4
    bw 1
  ]
  edge [
    source 4
    target 5
    bw 35
  ]
]
