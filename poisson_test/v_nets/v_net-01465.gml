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
  id 1465
  arrival_time 30709.513218403474
  lifetime 501.6244884813421
  num_nodes 4
  type "path"
  node [
    id 0
    label "0"
    cpu 10
    gpu 46
    rom 9
  ]
  node [
    id 1
    label "1"
    cpu 33
    gpu 3
    rom 21
  ]
  node [
    id 2
    label "2"
    cpu 1
    gpu 19
    rom 38
  ]
  node [
    id 3
    label "3"
    cpu 3
    gpu 32
    rom 43
  ]
  edge [
    source 0
    target 1
    bw 10
  ]
  edge [
    source 1
    target 2
    bw 20
  ]
  edge [
    source 2
    target 3
    bw 13
  ]
]
