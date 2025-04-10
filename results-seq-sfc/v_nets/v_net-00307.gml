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
  id 307
  arrival_time 5825.9304544184415
  lifetime 422.46107773079564
  num_nodes 3
  type "path"
  node [
    id 0
    label "0"
    cpu 12
    gpu 8
    rom 24
  ]
  node [
    id 1
    label "1"
    cpu 27
    gpu 7
    rom 31
  ]
  node [
    id 2
    label "2"
    cpu 48
    gpu 13
    rom 21
  ]
  edge [
    source 0
    target 1
    bw 29
  ]
  edge [
    source 1
    target 2
    bw 27
  ]
]
