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
  id 1166
  arrival_time 24203.097807505805
  lifetime 60.17662042620327
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 22
    gpu 29
    rom 15
  ]
  node [
    id 1
    label "1"
    cpu 20
    gpu 21
    rom 8
  ]
  node [
    id 2
    label "2"
    cpu 36
    gpu 42
    rom 9
  ]
  node [
    id 3
    label "3"
    cpu 8
    gpu 6
    rom 50
  ]
  node [
    id 4
    label "4"
    cpu 24
    gpu 10
    rom 13
  ]
  node [
    id 5
    label "5"
    cpu 10
    gpu 37
    rom 36
  ]
  edge [
    source 0
    target 1
    bw 46
  ]
  edge [
    source 1
    target 2
    bw 46
  ]
  edge [
    source 2
    target 3
    bw 17
  ]
  edge [
    source 3
    target 4
    bw 19
  ]
  edge [
    source 4
    target 5
    bw 25
  ]
]
