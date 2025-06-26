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
  id 433
  arrival_time 8416.004735488665
  lifetime 34.72876287132358
  num_nodes 4
  type "path"
  node [
    id 0
    label "0"
    cpu 50
    gpu 31
    rom 5
  ]
  node [
    id 1
    label "1"
    cpu 41
    gpu 45
    rom 33
  ]
  node [
    id 2
    label "2"
    cpu 42
    gpu 14
    rom 15
  ]
  node [
    id 3
    label "3"
    cpu 29
    gpu 16
    rom 45
  ]
  edge [
    source 0
    target 1
    bw 26
  ]
  edge [
    source 1
    target 2
    bw 46
  ]
  edge [
    source 2
    target 3
    bw 44
  ]
]
