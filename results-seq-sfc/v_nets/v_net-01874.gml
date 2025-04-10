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
  id 1874
  arrival_time 41102.83919603912
  lifetime 1534.3300879855879
  num_nodes 3
  type "path"
  node [
    id 0
    label "0"
    cpu 42
    gpu 33
    rom 36
  ]
  node [
    id 1
    label "1"
    cpu 16
    gpu 18
    rom 1
  ]
  node [
    id 2
    label "2"
    cpu 26
    gpu 9
    rom 49
  ]
  edge [
    source 0
    target 1
    bw 20
  ]
  edge [
    source 1
    target 2
    bw 50
  ]
]
