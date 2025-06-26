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
  id 916
  arrival_time 19639.120312096402
  lifetime 244.32233792772192
  num_nodes 3
  type "path"
  node [
    id 0
    label "0"
    cpu 16
    gpu 19
    rom 14
  ]
  node [
    id 1
    label "1"
    cpu 41
    gpu 20
    rom 21
  ]
  node [
    id 2
    label "2"
    cpu 6
    gpu 29
    rom 15
  ]
  edge [
    source 0
    target 1
    bw 24
  ]
  edge [
    source 1
    target 2
    bw 15
  ]
]
