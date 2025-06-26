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
  id 869
  arrival_time 18114.284831334815
  lifetime 1404.546823343748
  num_nodes 5
  type "path"
  node [
    id 0
    label "0"
    cpu 15
    gpu 24
    rom 24
  ]
  node [
    id 1
    label "1"
    cpu 49
    gpu 7
    rom 4
  ]
  node [
    id 2
    label "2"
    cpu 40
    gpu 22
    rom 33
  ]
  node [
    id 3
    label "3"
    cpu 26
    gpu 37
    rom 1
  ]
  node [
    id 4
    label "4"
    cpu 16
    gpu 39
    rom 34
  ]
  edge [
    source 0
    target 1
    bw 4
  ]
  edge [
    source 1
    target 2
    bw 24
  ]
  edge [
    source 2
    target 3
    bw 40
  ]
  edge [
    source 3
    target 4
    bw 22
  ]
]
