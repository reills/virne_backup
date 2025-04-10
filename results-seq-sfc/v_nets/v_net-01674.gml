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
  id 1674
  arrival_time 37302.822686568674
  lifetime 1014.7938090323707
  num_nodes 3
  type "path"
  node [
    id 0
    label "0"
    cpu 12
    gpu 27
    rom 31
  ]
  node [
    id 1
    label "1"
    cpu 8
    gpu 39
    rom 33
  ]
  node [
    id 2
    label "2"
    cpu 2
    gpu 28
    rom 9
  ]
  edge [
    source 0
    target 1
    bw 33
  ]
  edge [
    source 1
    target 2
    bw 5
  ]
]
