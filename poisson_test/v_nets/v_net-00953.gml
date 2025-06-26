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
  id 953
  arrival_time 20326.94576712922
  lifetime 39.905482744292364
  num_nodes 3
  type "path"
  node [
    id 0
    label "0"
    cpu 17
    gpu 21
    rom 45
  ]
  node [
    id 1
    label "1"
    cpu 38
    gpu 44
    rom 34
  ]
  node [
    id 2
    label "2"
    cpu 13
    gpu 41
    rom 26
  ]
  edge [
    source 0
    target 1
    bw 9
  ]
  edge [
    source 1
    target 2
    bw 3
  ]
]
